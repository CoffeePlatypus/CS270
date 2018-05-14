/**
 * CS 270: Solver template for Assignment 02
 * See assignment document for details.
 */
public class Solver {

	private int[] powersOf2;

	/**
	 * Testing method for the Solver class that allows it to be run by itself
	 * without the Driver. This code may be helpful for testing and debugging.
	 * Feel free to modify the method for your own testing purposes.
	 *
	 * @param args
	 */
	public static void main(String[] args) {

		Solver s = new Solver();
		int min = -8;
		int max = +7;
		for (int i = min; i <= max; ++i) {
			char[] binaryStr = s.decimalToBinary(i);
			System.out.format("%5d: %10s%n", i, Driver.arrayToString(binaryStr));
		}
	}

	/**
	 * Constructor for the Solver. It should allocate memory for and initialize
	 * the powersOf2 member array.
	 */
	public Solver() {
		// TODO: Initialize the powersOf2 array with the first 16 powers of 2.
	}

	/**
	 * Determines the number of bits needed to represent the given value in
	 * two's complement binary.
	 *
	 * @param value The value to represent.
	 * @return The number of bits needed.
	 */
	public int howManyBits(int value) {
		// TODO: Implement this method.
		return 0;
	}

	/**
	 * Converts the given value into a two's complement binary number
	 * represented as an array of char. The array should use the minimal
	 * number of bits that is necessary.
	 *
	 * @param value The value to convert.
	 * @return A char array of 0's and 1's representing the number in two's
	 *         complement binary. The most significant bit should be stored in
	 *         position 0 in the array.
	 */
	public char[] decimalToBinary(int value) {
		// TODO: Implement this method.
		return null;
	}

	/**
	 * Computes the two's complement (negation) of the given two's complement
	 * binary number and returns the result.
	 *
	 * @param binaryStr The binary number to negate.
	 * @return The negated number in two's complement binary.
	 */
	public char[] twosComplementNegate(char[] binaryStr) {
		// TODO: Implement this method.
		return null;
	}

	/**
	 * Applies sign extension to the given two's complement binary number so
	 * that it is stored using the given number of bits. If the number of bits
	 * is smaller than the length of the input array, the input array itself
	 * should be returned.
	 *
	 * @param binaryStr The binary number to sign-extend.
	 * @param numBits The number of bits to use.
	 * @return The sign-extended binary number.
	 */
	public char[] signExtend(char[] binaryStr, int numBits) {
		// TODO: Implement this method.
		return null;
	}

	/**
	 * Evaluates the expression given by the two's complement binary numbers
	 * and the specified operator.
	 *
	 * @param binaryStr1 The first number.
	 * @param op The operator to apply (either "+" or "-").
	 * @param binaryStr2 The second number.
	 * @return The result from evaluating the expression, in two's complement
	 *         binary. Note that a '*' should be appended to the returned
	 *         result if overflow occurred.
	 */
	public char[] evaluateExpression(char[] binaryStr1, String op, char[] binaryStr2) {
		// TODO: Implement this method.
		return binaryStr1;
	}

}
