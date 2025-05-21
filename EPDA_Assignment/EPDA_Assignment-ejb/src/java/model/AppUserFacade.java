package model;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 * AppUserFacade is a facade for managing AppUser entities.
 */
@Stateless
public class AppUserFacade extends AbstractFacade<AppUser> {

    @PersistenceContext(unitName = "EPDA_Assignment-ejbPU")
    private EntityManager em;

    public AppUserFacade() {
        super(AppUser.class);
    }

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }
}
