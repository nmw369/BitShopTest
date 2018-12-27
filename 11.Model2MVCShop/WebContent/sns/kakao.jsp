 <!DOCTYPE html>
    <html>
    <head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width"/>
    <title>Kakao JavaScript SDK</title>
    <script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>

    </head>
    <body>
    <a id="kakao-login-btn"></a>
      <a href="http://developers.kakao.com/logout">logout</a>
    <script type='text/javascript'>
     
     
        Kakao.init('267da5a91cd9ec34d394300341892c43');
     
        Kakao.Auth.createLoginButton({
          container: '#kakao-login-btn',
          success: function(authObj) {
        	  alert(JSON.stringify(authObj));
        	  alert("a");
        	  Kakao.API.request({
                  url: '/v1/user/me',
                  success: function(res) {
                	  
                	  alert(JSON.stringify(res));
                	  alert(res.properties.nickname);
                    
                  },
                  fail: function(error) {
                    alert(JSON.stringify(error)+"::::::");
                  }
                });
            
          },
          fail: function(err) {
             alert(JSON.stringify(err));
          }
        });
     
    </script>

    </body>
    </html>