<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="GenerateRandom.genRandomNumber" %>
<%@ page import="genrateCurrDate.fetchDate" %>
<% 
    int billno = genRandomNumber.genRanNumber();
    String currdate = fetchDate.getCurrentDate();
%>
<% 
    String msg = null;
    msg = request.getParameter("msg");
    if("select".equals(msg))
    {
        msg = "Choose a payment type..";
    }
    if("add".equals(msg))
    {
        msg = "Bill Create Successfully..";
    }
    if("notadd".equals(msg))
    {
        msg = "Bill not Create Successfully..";
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <%@ include file="header.jsp"%>
    <style>
        .suggestions {
            position: absolute;
            z-index: 1000;
            background-color: white;
            border: 1px solid #ccc;
            width: 100%;
            max-height: 150px;
            overflow-y: auto;
            display: none;
        }
        .suggestion-item {
            padding: 8px;
            cursor: pointer;
        }
        .suggestion-item:hover {
            background-color: #f0f0f0;
        }
        .form-control {
            display: inline-block;
            width: 100%;
        }
        table th, table td {
            text-align: center;
            vertical-align: middle;
            padding: 8px;
        }
        .input-wrapper {
            position: relative;
        }
        .table-container {
            margin-top: 20px;
            overflow-x: auto;
        }
        .table-footer {
            font-weight: bold;
            text-align: right;
        }
        .product-details-table {
            text-align: left;
            margin-bottom: 20px;
            padding-bottom: 10px;
        }
        .medicine-info {
            margin-top: 10px;
            font-weight: bold;
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function(){
            // Function to add new row to the table
            $("#add").click(function() {
                var html = '<tr>';
                html += '<td><div class="input-wrapper"><input type="text" name="name[]" class="form-control name-field"><div class="suggestions"></div></div></td>';
                html += '<td><input type="text" name="companyname[]" class="form-control companyname-field" readonly></td>';
                html += '<td><input type="text" name="expirydate[]" class="form-control expirydate-field" readonly></td>';
                html += '<td><input type="text" name="packsize[]" class="form-control packsize-field" readonly></td>';
                html += '<td><input type="number" name="quantity[]" class="form-control quantity-field" min="1" required=""></td>';
                html += '<td><input type="text" name="price[]" class="form-control price-field" readonly></td>';
                html += '<td><input type="text" name="totalprice[]" class="form-control totalprice-field" readonly></td>';
                html += '<td><input type="hidden" name="mid[]" class="mid-field"><input type="hidden" name="totalpack[]" class="totalpack-field"><button type="button" class="btn btn-danger remove-tr">Remove</button></td>';
                html += '</tr>';
                $('#dynamicTable tbody').append(html);
            });

            // Function to remove a row from the table
            $(document).on('click', '.remove-tr', function() {
                $(this).closest('tr').remove();
                calculateGrandTotal();
                updateMedicineInfo();
            });

            // Function to fetch medicine details and handle suggestions
            $(document).on('input', '.name-field', function(){
                var input = $(this);
                var term = input.val();

                if(term.length > 1) {
                    $.ajax({
                        url: '../fetchDetails/fetchMedicineDetails.jsp',
                        method: 'GET',
                        data: { term: term },
                        success: function(response){
                            var suggestionsDiv = input.siblings('.suggestions');
                            suggestionsDiv.empty();
                            response.forEach(function(medicine) {
                                suggestionsDiv.append('<div class="suggestion-item" data-name="' + medicine.name + '" data-company-name="' + medicine.company_name + '" data-batch-no="' + medicine.batch_no + '" data-packsize="' + medicine.packsize + '" data-price="' + medicine.price + '" data-expirydate="' + medicine.expirydate + '" data-mid="' + medicine.mid + '" data-totalpack="' + medicine.totalpack + '">' + medicine.name + ' - ' + medicine.company_name + ' - ' + medicine.batch_no + '</div>');
                            });
                            suggestionsDiv.show();
                        },
                        error: function(xhr, status, error) {
                            console.log("AJAX Error: ", error);
                        }
                    });
                } else {
                    input.siblings('.suggestions').hide();
                }
            });

            // Function to populate fields on suggestion click
            $(document).on('click', '.suggestion-item', function(){
                var item = $(this);
                var input = item.closest('.input-wrapper').find('.name-field');
                var row = input.closest('tr');
                input.val(item.data('name'));
                row.find('.companyname-field').val(item.data('company-name'));
                row.find('.expirydate-field').val(item.data('expirydate'));
                row.find('.packsize-field').val(item.data('packsize'));
                row.find('.price-field').val(item.data('price'));
                row.find('.mid-field').val(item.data('mid'));
                row.find('.totalpack-field').val(item.data('totalpack'));
                row.find('.suggestions').hide();

                // Display selected medicine info
                var medicineInfo = 'Medicine Name : ' + item.data('name') + '<br>'
                     + 'Company Name : ' + item.data('company-name') + '<br>'
                     + 'Available Quantity : ' + item.data('totalpack');
                $('#medicineInfo').html(medicineInfo);
                calculateRowTotal(row);
            });

            // Function to calculate total price when quantity is entered
            $(document).on('input', '.quantity-field', function() {
                var row = $(this).closest('tr');
                var maxQuantity = parseFloat(row.find('.totalpack-field').val()) || 0;
                var quantity = parseFloat($(this).val()) || 0;

                // Check if quantity exceeds maxQuantity
                if(quantity > maxQuantity) {
                    alert('Quantity exceeds available stock');
                    $(this).val(maxQuantity);
                    quantity = maxQuantity;
                }

                calculateRowTotal(row);
            });

            // Function to calculate the total price for a row
            function calculateRowTotal(row) {
                var quantity = parseFloat(row.find('.quantity-field').val()) || 0;
                var price = parseFloat(row.find('.price-field').val()) || 0;
                var total = quantity * price;
                row.find('.totalprice-field').val(total.toFixed(2));
                calculateGrandTotal();
            }

            // Function to calculate the grand total
            function calculateGrandTotal() {
                var grandTotal = 0;
                $('#dynamicTable tbody tr').each(function() {
                    var rowTotal = parseFloat($(this).find('.totalprice-field').val()) || 0;
                    grandTotal += rowTotal;
                });
                $('#grandTotal').val(grandTotal.toFixed(2));
                calculateDiscountedTotal();
            }

            // Function to calculate the discounted total
            $(document).on('input', '#discount', function() {
                calculateDiscountedTotal();
            });

            function calculateDiscountedTotal() {
                var grandTotal = parseFloat($('#grandTotal').val()) || 0;
                var discount = parseFloat($('#discount').val()) || 0;
                var discountedTotal = grandTotal - (grandTotal * discount / 100);
                $('#discountedTotal').val(discountedTotal.toFixed(2));
            }

            // Function to update medicine info based on the current rows
            function updateMedicineInfo() {
                var lastRow = $('#dynamicTable tbody tr:last');
                if (lastRow.length === 0) {
                    $('#medicineInfo').html(''); // Clear medicine info if no rows are left
                } else {
                    var item = lastRow.find('.suggestion-item');
                    if (item.length > 0) {
                        var medicineInfo = 'Medicine Name : ' + item.data('name') + '<br>'
                                           + 'Company Name : ' + item.data('company-name') + '<br>'
                                           + 'Available Quantity : ' + item.data('totalpack');
                        $('#medicineInfo').html(medicineInfo);
                    }
                }
            }

            // Hide suggestions on click outside
            $(document).click(function(event) {
                if (!$(event.target).closest('.name-field').length) {
                    $('.suggestions').hide();
                }
            });
        });
    </script>
</head>
<body>
    <%@ include file="navbar.jsp"%>

    <div class="content-body">
        <div class="row page-titles mx-0">
            <div class="col p-md-0">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="dashboard.jsp">Dashboard</a></li>
                    <li class="breadcrumb-item active"><a href="makebill.jsp">Make Bill</a></li>
                </ol>
            </div>
        </div>

        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-12">
                    <div class="card">
                        <div class="card-body">
                            <% if(msg != null) { %>
                                <div class="alert alert-warning alert-dismissible fade show" role="alert">
                                    <%= msg %>
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                            <% } %>
                            <h4 class="card-title">Make Bill</h4>
                            <div class="basic-form mt-4">
                                <form action="../addAction/addBill.jsp" method="post">
                                    <div class="form-row">
                                        <div class="form-group col-md-6">
                                            <label>Customer Name*</label>
                                            <input type="text" class="form-control" name="cname" required="" maxlength="50">
                                        </div>
                                        <div class="form-group col-md-6">
                                            <label>Doctor Name*</label>
                                            <input type="text" class="form-control" name="dname" required="" maxlength="50">
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="form-group col-md-4">
                                            <label>Address*</label>
                                            <input type="text" class="form-control" name="address" required="" maxlength="50">
                                        </div>
                                        <div class="form-group col-md-4">
                                            <label>Date*</label>
                                            <input type="text" class="form-control" name="date" readonly="" value="<%= currdate %>">
                                        </div>
                                        <div class="form-group col-md-4">
                                            <label>Bill No*</label>
                                            <input type="text" class="form-control" name="billno" readonly="" value="<%= billno %>">
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="form-group col-md-6">
                                            <label>Contact No*</label>
                                            <input type="text" class="form-control" name="contact" required="" minlength="10" maxlength="10">
                                        </div>
                                        <div class="form-group col-md-6">
                                            <label>Payment Type*</label>
                                            <select name="ptype" class="form-control" required="">
                                                <option selected="selected" value="0">Select..</option>
                                                <option value="cash">Cash</option>
                                                <option value="online">Online</option>
                                                <option value="cheque">Cheques</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="table-container">
                                        <h4 class="product-details-table">Product Details</h4>
                                        <table class="table table-bordered" id="dynamicTable">
                                            <thead>
                                                <tr>
                                                    <th>Medicine Name*</th>
                                                    <th>Company Name</th>
                                                    <th>Expiry Date</th>
                                                    <th>Pack Size</th>
                                                    <th>Quantity*</th>
                                                    <th>Price</th>
                                                    <th>Total Price</th>
                                                    <th>Action</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td>
                                                        <div class="input-wrapper">
                                                            <input type="text" name="name[]" class="form-control name-field" autocomplete="off">
                                                            <div class="suggestions"></div>
                                                        </div>
                                                    </td>
                                                    <td><input type="text" name="companyname[]" class="form-control companyname-field" readonly></td>
                                                    <td><input type="text" name="expirydate[]" class="form-control expirydate-field" readonly></td>
                                                    <td><input type="text" name="packsize[]" class="form-control packsize-field" readonly></td>
                                                    <td><input type="number" name="quantity[]" class="form-control quantity-field" min="1" required=""></td>
                                                    <td><input type="text" name="price[]" class="form-control price-field" readonly></td>
                                                    <td><input type="text" name="totalprice[]" class="form-control totalprice-field" readonly></td>
                                                    <td>
                                                        <input type="hidden" name="mid[]" class="mid-field">
                                                        <input type="hidden" name="totalpack[]" class="totalpack-field">
                                                        <button type="button" class="btn btn-danger remove-tr">Remove</button>
                                                    </td>
                                                </tr>
                                            </tbody>
                                            <tfoot>
                                                <tr>
                                                    <td colspan="7" class="table-footer">Grand Total</td>
                                                    <td><input type="text" id="grandTotal" name="grandTotal" class="form-control" readonly></td>
                                                </tr>
                                                <tr>
                                                    <td colspan="7" class="table-footer">Discount (%)</td>
                                                    <td><input type="text" id="discount" name="discount" value="0" maxlength="3" class="form-control"></td>
                                                </tr>
                                                <tr>
                                                    <td colspan="7" class="table-footer">Discounted Total</td>
                                                    <td><input type="text" id="discountedTotal" name="discountedTotal" class="form-control" readonly></td>
                                                </tr>
                                            </tfoot>
                                            <div id="medicineInfo" class="medicine-info  mb-3 pb-2" style="text-align: center; color: red;"></div>
                                        </table>
                                        <button type="button" name="add" id="add" class="btn btn-success">Add Row</button>
                                        <button type="submit" class="btn btn-primary ml-3 pl-3">Submit</button>
                                    </div>
                                    
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%@ include file="footer.jsp"%>
</body>
</html>
