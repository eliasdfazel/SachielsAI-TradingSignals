/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 7/27/22, 5:44 PM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

double calculatePercentage(int percentageAmount, double completeValue) {

  double resultValue = completeValue.toDouble();

  resultValue = (completeValue * percentageAmount) / 100;

  return resultValue;
}

double degreeToRadian(double degree) {

  double mathPI = 3.141592653589793238;

  return degree * mathPI / 180;
}