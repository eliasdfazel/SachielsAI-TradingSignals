/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 7/11/22, 7:02 PM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

double calculatePercentage(int percentageAmount, double completeValue) {

  double resultValue = completeValue.toDouble();

  resultValue = (completeValue * percentageAmount) / 100;

  return resultValue;
}