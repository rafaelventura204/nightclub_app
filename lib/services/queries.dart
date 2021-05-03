class Queries {
  var query;
  String registerUserQuery() {
    query =
        'INSERT INTO public."user"( username, password) VALUES (@email, @psw);';
    return query;
  }

  String loginUserQuery() {
    query = 'SELECT "username" FROM public."user" WHERE "username" = @email';
    return query;
  }
}
