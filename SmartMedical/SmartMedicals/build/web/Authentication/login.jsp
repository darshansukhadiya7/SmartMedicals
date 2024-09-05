<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String msg = request.getParameter("msg");
    if("invalid".equals(msg))
    {
        msg = "Username and password invalid...";
    }
    if("sessionExpired".equals(msg))
    {
        msg = "session expired..again login";
    }
%>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

    <title>Smart Medicals</title>
  </head>
  <body>
    <section class="vh-100" style="background-color: color-mix(in srgb, #34c9eb, white);">
        <div class="container py-5 h-100">
          <div class="row d-flex justify-content-center align-items-center h-100">
            <div class="col-12 col-md-8 col-lg-6 col-xl-5">
              <div class="card shadow-2-strong" style="border-radius: 1rem;">
                <div class="card-body p-5 text-center">

                  <h3 class="mb-5">Sign in</h3>
                  <form action="verifyAdmin.jsp" method="post">
                    <div data-mdb-input-init class="form-outline mb-4">
                        <input type="text" name="username" required="" class="form-control form-control-lg" />
                      <label class="form-label">Username</label>
                    </div>

                    <div data-mdb-input-init class="form-outline mb-4">
                        <input type="password" name="password" required="" class="form-control form-control-lg" />
                      <label class="form-label">Password</label>
                    </div>

                    <!-- Checkbox -->
                    <div class="form-check d-flex justify-content-start mb-4">
                        <%
                            if(msg != null)
                            { %>
                            <label class="form-check-label" for="form1Example3" style="color: red;"><%= msg %></label>
                            <% }
                        %>
                        
                    </div>

                    <button data-mdb-button-init data-mdb-ripple-init class="btn btn-primary btn-lg btn-block" type="submit">Login</button>
                  </form>
                
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
  </body>
</html>