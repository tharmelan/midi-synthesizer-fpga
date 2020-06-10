import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class FourierCoefficientsToFormula {

    private static final String fourierCoefficents = "Harmonic 1 (-1.937) 972.0\n" +
            "    ,Harmonic 2 1.5e-2 110.39\n" +
            "    ,Harmonic 3 (-1.488) 353.86\n" +
            "    ,Harmonic 4 (-0.313) 193.81\n" +
            "    ,Harmonic 5 2.853 33.06\n" +
            "    ,Harmonic 6 (-0.46) 87.82\n" +
            "    ,Harmonic 7 1.985 25.57\n" +
            "    ,Harmonic 8 (-0.719) 17.09\n" +
            "    ,Harmonic 9 2.218 15.11\n" +
            "    ,Harmonic 10 (-0.244) 0.76\n" +
            "    ,Harmonic 11 2.308 7.93\n" +
            "    ,Harmonic 12 (-2.572) 7.27\n" +
            "    ,Harmonic 13 (-3.9e-2) 6.58\n" +
            "    ,Harmonic 14 2.642 6.24\n" +
            "    ,Harmonic 15 0.478 3.51\n" +
            "    ,Harmonic 16 1.442 0.68";

    public static void main(String[] args) {
        List<String> tmp = Arrays.asList(fourierCoefficents.split("\n"));
        StringBuilder sb = new StringBuilder();
        tmp.forEach(s -> {
            String[] coefitent = s.trim().split(" ");
            if (Double.valueOf(coefitent[3]) > 20) {
                sb.append(coefitent[3]).append("*cos(2*pi*x*").append(coefitent[1]).append("-").append(coefitent[2]).append(")+");
            }
        });

        System.out.println(sb.deleteCharAt(sb.length()-1).toString());
    }
}
