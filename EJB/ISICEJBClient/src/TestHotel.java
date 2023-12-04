import java.util.Hashtable;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;

import dao.IDaoRemote;
import entities.Hotel;
import entities.Ville;

public class TestHotel {

    public static IDaoRemote<Hotel> lookUpHotelRemote() throws NamingException {
        final Hashtable jndiProperties = new Hashtable();
        jndiProperties.put(Context.INITIAL_CONTEXT_FACTORY, "org.wildfly.naming.client.WildFlyInitialContextFactory");
        jndiProperties.put(Context.PROVIDER_URL, "http-remoting://localhost:8084");
        final Context context = new InitialContext(jndiProperties);

        return (IDaoRemote<Hotel>) context.lookup("ejb:ISICEJBEAR/ISICEJBServer/hotelService!dao.IDaoRemote");
    }

    public static void main(String[] args) {

        try {
            IDaoRemote<Hotel> dao = lookUpHotelRemote();
            Ville ville = new Ville();
            ville.setNom("test");
           
            dao.create(new Hotel("Hotel A", "Adresse A", "123456789",ville));
            dao.create(new Hotel("Hotel B", "Adresse B", "987654321",ville));

            for (Hotel h : dao.findAll()) {
                System.out.println(h.getNom() + " - " + h.getAdresse() + " - " + h.getTelephone());
            }
        } catch (NamingException e) {
            e.printStackTrace();
        }
    }
}
