OPENQASM 2.0;
include "qelib1.inc";
qreg q[11];
creg c[3];
// These introductory lines initialize 11 quantum registers and 3 classical registers.

x q[1]; // q[1]q[0] is binary 10 (decimal 2)
x q[3]; // q[3]q[2] is binary 10 (decimal 2)
// All qubits start with a value of 0. Above, the values of the 2nd and 4th qubits are changed to 1. I use the 1st 2 qubits for the 1st number and the 2nd 2 qubits for the 2nd number.

barrier q; // half adder
cx q[0], q[4];
cx q[2], q[4]; // sum
ccx q[0], q[2], q[5]; // carry
// A half adder accepts 2 inputs, and then outputs the sum and the carry.

barrier q; // full adder
cx q[1], q[6];
cx q[3], q[6]; // XOR1
ccx q[1], q[3], q[7]; // AND1
cx q[6], q[8];
cx q[5], q[8]; // XOR2
ccx q[4], q[5], q[9]; // AND2
barrier q; // OR
x q[7];
x q[9];
ccx q[7], q[9], q[10];
x q[10];
// A full adder accepts 3 inputs, including the previous carry. It outputs the sum and a new carry.

measure q[4] -> c[0];
measure q[8] -> c[1];
measure q[10] -> c[2];
// This produces the output, in binary. The 1st qubit is the sum from the half adder, the 2nd qubit is the sum from the full adder, and the 3rd qubit is the carry from the full adder.
