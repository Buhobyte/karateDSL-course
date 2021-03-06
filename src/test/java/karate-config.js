function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    apiUrl: 'https://conduit.productionready.io/api/'
  }
  if (env == 'perform') {
    config.userEmail = 'buho@gmail.com'
    config.userPassword = '123456'
  } else if (env == 'qa') {
    config.userEmail = 'buho@gmail.com'
    config.userPassword = '123456'
  }

  if (env != 'perform') {
    var accessToken = karate.callSingle('classpath:helpers/CreateToken.feature', config).authToken;
    karate.configure('headers', { 'Authorization': 'Token ' + accessToken });
  }

  return config;
}