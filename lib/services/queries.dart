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

  String getCategoryQuery() {
    query = 'SELECT * FROM public.category;';
    return query;
  }

  String loadUserCatQuery() {
    query =
        'INSERT INTO public.user_category(id_user, id_category)VALUES (@idUser, @idCatgory);';
    return query;
  }

  String getUserCategoryQuery() {
    query =
        'SELECT category.name_category FROM public.user_category 	INNER JOIN public.category 	ON user_category.id_category = category.id	WHERE user_category.id_user = @idUser';

    return query;
  }

  String removeUserCategoryQuery() {
    query =
        'DELETE FROM user_category U WHERE U.id_user = @idUser AND U.id_category IN (SELECT C.id FROM  category C WHERE  C.name_category = @idCategory); ';

    return query;
  }

  String getNightlifeQuery() {
    query = 'SELECT * FROM public.nightlife ORDER BY id ASC ';
    return query;
  }
}
