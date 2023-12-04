package services;

import java.util.List;
import dao.IDaoLocale;
import dao.IDaoRemote;
import entities.Hotel;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;

@Stateless(name = "hotelService")
public class HotelService implements IDaoRemote<Hotel>, IDaoLocale<Hotel> {

	@PersistenceContext
	private EntityManager em;

	@Override
	public Hotel create(Hotel o) {
		em.persist(o);
		return o;
	}

	@Override
	public boolean delete(Hotel o) {
		try {
			em.remove(em.merge(o));
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	@Override
	public Hotel update(Hotel o) {
		try {
			return em.merge(o);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	@Override
	public Hotel findById(int id) {
		return em.find(Hotel.class, id);
	}

	@Override
	public List<Hotel> findAll() {
		Query query = em.createQuery("select h from Hotel h");
		return query.getResultList();
	}
}
