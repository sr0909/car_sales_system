package model;

import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2024-09-12T17:36:39")
@StaticMetamodel(AppUser.class)
public class AppUser_ { 

    public static volatile SingularAttribute<AppUser, String> user_role;
    public static volatile SingularAttribute<AppUser, String> password;
    public static volatile SingularAttribute<AppUser, Long> id;
    public static volatile SingularAttribute<AppUser, String> email;
    public static volatile SingularAttribute<AppUser, String> username;

}