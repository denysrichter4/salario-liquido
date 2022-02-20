import 'package:salario_liquido/domain/constants.dart';

class Controller{

  double liquido(double bruto, double outroDesconto, double dependent){
    return bruto - total(bruto, outroDesconto, dependent);
  }

  double total(double bruto, double outroDesconto, double dependent){
    return calculateInss(bruto) + calculateIrrf(bruto, dependent) + outroDesconto;
  }

  double calculateIrrf(double bruto, double dependent){
    var total = bruto - (dependent * Constants.VALUE_PER_DEPENDENT);
    var result =  total  - calculateInss(bruto);

    if(result < Constants.VALUE_IRRF_ISENT){
      return Constants.VALUE_PERCENT_IRRF_ISENT;
    }else if(result >= Constants.VALUE_IRRF_ISENT && result < Constants.VALUE_IRRF_7_5){
      return (result * Constants.VALUE_PERCENT_IRRF_7_5) - (Constants.VALUE_PERCENT_IRRF_7_5_DEDUCT);
    }else if(result >= Constants.VALUE_IRRF_7_5 && result < Constants.VALUE_IRRF_15){
      return (result * Constants.VALUE_PERCENT_IRRF_15) - (Constants.VALUE_PERCENT_IRRF_15_DEDUCT);
    }else if(result >= Constants.VALUE_IRRF_15 && result < Constants.VALUE_IRRF_22_5){
      return (result * Constants.VALUE_PERCENT_IRRF_22_5) - (Constants.VALUE_PERCENT_IRRF_22_5_DEDUCT);
    }else if(result >= Constants.VALUE_IRRF_22_5){
      return (result * Constants.VALUE_PERCENT_IRRF_27_5) - Constants.VALUE_PERCENT_IRRF_27_5_DEDUCT;
    }else{
      return (result * Constants.VALUE_PERCENT_IRRF_27_5) - Constants.VALUE_PERCENT_IRRF_27_5_DEDUCT;
    }
  }

  double calculateInss(double bruto){
    if(bruto < Constants.VALUE_INSS_7_5){
      return faixa1(bruto);
    }else if(bruto >= Constants.VALUE_INSS_7_5 && bruto < Constants.VALUE_INSS_9){
      return faixa2(bruto);
    }else if(bruto >= Constants.VALUE_INSS_9 && bruto < Constants.VALUE_INSS_12){
      return faixa3(bruto);
    }else if(bruto >= Constants.VALUE_INSS_12){
      return faixa4(bruto);
    }else{
      return faixa4(bruto);
    }
  }

  double faixa1(double bruto){
    return bruto * Constants.VALUE_PERCENT_INSS_7_5;
  }

  double faixa2(double bruto){
    return ((bruto - Constants.VALUE_INSS_7_5) * Constants.VALUE_PERCENT_INSS_9) +
        (Constants.VALUE_INSS_7_5 * Constants.VALUE_PERCENT_INSS_7_5);
  }

  double faixa3(double bruto){
    return ((bruto - Constants.VALUE_INSS_9) * Constants.VALUE_PERCENT_INSS_12) +
        ((Constants.VALUE_INSS_9 - Constants.VALUE_INSS_7_5 )* Constants.VALUE_PERCENT_INSS_9) +
        (Constants.VALUE_INSS_7_5 * Constants.VALUE_PERCENT_INSS_7_5);
  }

  double faixa4(double bruto){
    return ((bruto - Constants.VALUE_INSS_12) * Constants.VALUE_PERCENT_INSS_14) +
        ((Constants.VALUE_INSS_12 - Constants.VALUE_INSS_9 ) * Constants.VALUE_PERCENT_INSS_12) +
        ((Constants.VALUE_INSS_9 - Constants.VALUE_INSS_7_5 ) * Constants.VALUE_PERCENT_INSS_9) +
        (Constants.VALUE_INSS_7_5 * Constants.VALUE_PERCENT_INSS_7_5);
  }

}
