import java.io.IOException;

import com.google.maps.GeoApiContext;
import com.google.maps.GeocodingApi;
import com.google.maps.errors.ApiException;
import com.google.maps.model.GeocodingResult;

public class Teste {

	public static void main(String[] args) throws ApiException, InterruptedException, IOException {
		GeoApiContext context = new GeoApiContext.Builder().apiKey("AIzaSyCmwRyVP35MdWUXJ3v6reS_1UhCMuN7nmg").build();
		
		StringBuilder sb = new StringBuilder();
		sb.append("1100" + " ");
		sb.append("paranapanema ,");
		sb.append(" " + "RJ");
		
		GeocodingResult[] results = GeocodingApi.geocode(context, sb.toString()).await();

		System.out.println(String.valueOf(results[0].geometry.location.lat));
		System.out.println(results[0].geometry.location.lng);

	}

}
