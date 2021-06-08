class Queries {
  var query;

  String registerUserQuery() {
    query =
        'INSERT INTO public."user"( username, password) VALUES (@email, crypt(@psw, gen_salt(@bf)));';

    return query;
  }

  String loginUserQuery() {
    query =
        'SELECT "username" FROM public."user" WHERE "username" = @email AND password = crypt(@psw, password);';
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

  String loadUserNightlifeQuery() {
    query =
        'INSERT INTO public.user_nightlife(	id_user, id_nightlife) VALUES (@idUser,@idNightlife);';
    return query;
  }

  String removeUserNightlifeQuery() {
    query =
        'DELETE FROM public.user_nightlife	WHERE id_user = @idUser AND id_nightlife = @idNightlife;';

    return query;
  }

  String getNightlifeCategoryQuery() {
    query =
        'SELECT C.name_category	FROM public.category C INNER JOIN public.nightlife_category ON C.id = public.nightlife_category.id_category	WHERE public.nightlife_category.id_nightlife = @idNightlife;';

    return query;
  }

  String getUserNightlifeQuery() {
    // query =
    //     'SELECT C.name_category, N.name, N.address, N.url_image, N.latitudine, N.longitudine FROM public.user_nightlife U	INNER JOIN public.nightlife_category NC ON U.id_nightlife = NC.id_nightlife	INNER JOIN public.category C ON NC.id_category = C.id	INNER JOIN public.nightlife N ON N.id = U.id_nightlife WHERE U.id_user = @idUser;';
    query =
        'SELECT id_nightlife FROM public.user_nightlife WHERE id_user = @idUser;';
    return query;
  }
}
