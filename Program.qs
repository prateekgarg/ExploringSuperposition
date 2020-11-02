namespace ExploringSuperposition {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Arrays;
    open Microsoft.Quantum.Convert;

    // When running the program, make sure that you only have only Entry point. 
    // Feel free to create a master entry point and call these operations below from there.

    // Part 1: Dump the simulated quantum machine state at initialization, superposition, measurement and reset states
    // @EntryPoint()
    operation GenerateRandomBit() : Result {
        using (q = Qubit()) {
            Message("Initialized qubit:");
            DumpMachine();
            Message(" ");
            H(q);
            Message("Qubit after applying H:");
            DumpMachine();
            Message(" ");
            let randomBit = M(q);
            Message("Qubit after the measurement:");
            DumpMachine();
            Message(" ");
            Reset(q);
            Message("Qubit after resetting:");
            DumpMachine();
            Message(" ");
            return randomBit;
        }
    }

    // Part 2: Single qubit skewed probability superposition
    // Here alpha is the probability of the bit being in Zero state and (1 - alpha) is the probability of it being in One
    // This is achieved by using the operator Ry(2 * arcCos(sqrt(alpha))) on the qubit 
    // @EntryPoint()
    operation GenerateSpecificState(alpha : Double) : Result {
        using (q = Qubit()) {
            Ry(2.0 * ArcCos(Sqrt(alpha)), q);
            Message("The qubit is in the desired state");
            Message("");
            DumpMachine();
            Message("");
            Message("Skewed random bit is : ");
            return M(q);
        }
    }

    // Using multiple (3) qubits to generate a random number. Uniform probability exists for each bit, so there
    // is equal probability of getting numbers from 0 to 7
    // @EntryPoint()
    operation GenerateRandomNumber() : Int {
        using (qubits = Qubit[3]) {
            ApplyToEach(H, qubits);
            Message("The qubit register in a uniform superposition:");
            DumpMachine();
            let result = ForEach(M, qubits);
            Message("Measuring the qubits collapses the superposition to a basis state.");
            DumpMachine();
            return BoolArrayAsInt(ResultArrayAsBoolArray(result));
        }
    }

    // Final part  of the exercise where you dump the simulated machine state after every bit measurement to
    // show how we arrive at the random number
    //
    // OUTPUT:
    // 
    // The qubit register in a uniform superposition:
    // # wave function for qubits with ids (least to most significant): 0;1;2
    // ∣0❭:     0.353553 +  0.000000 i  ==     ***                  [ 0.125000 ]     --- [  0.00000 rad ]
    // ∣1❭:     0.353553 +  0.000000 i  ==     ***                  [ 0.125000 ]     --- [  0.00000 rad ]
    // ∣2❭:     0.353553 +  0.000000 i  ==     ***                  [ 0.125000 ]     --- [  0.00000 rad ]
    // ∣3❭:     0.353553 +  0.000000 i  ==     ***                  [ 0.125000 ]     --- [  0.00000 rad ]
    // ∣4❭:     0.353553 +  0.000000 i  ==     ***                  [ 0.125000 ]     --- [  0.00000 rad ]
    // ∣5❭:     0.353553 +  0.000000 i  ==     ***                  [ 0.125000 ]     --- [  0.00000 rad ]
    // ∣6❭:     0.353553 +  0.000000 i  ==     ***                  [ 0.125000 ]     --- [  0.00000 rad ]
    // ∣7❭:     0.353553 +  0.000000 i  ==     ***                  [ 0.125000 ]     --- [  0.00000 rad ]

    // # wave function for qubits with ids (least to most significant): 0;1;2
    // ∣0❭:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
    // ∣1❭:     0.500000 +  0.000000 i  ==     *****                [ 0.250000 ]     --- [  0.00000 rad ]
    // ∣2❭:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
    // ∣3❭:     0.500000 +  0.000000 i  ==     *****                [ 0.250000 ]     --- [  0.00000 rad ]
    // ∣4❭:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
    // ∣5❭:     0.500000 +  0.000000 i  ==     *****                [ 0.250000 ]     --- [  0.00000 rad ]
    // ∣6❭:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
    // ∣7❭:     0.500000 +  0.000000 i  ==     *****                [ 0.250000 ]     --- [  0.00000 rad ]

    // # wave function for qubits with ids (least to most significant): 0;1;2
    // ∣0❭:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
    // ∣1❭:     0.707107 +  0.000000 i  ==     **********           [ 0.500000 ]     --- [  0.00000 rad ]
    // ∣2❭:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
    // ∣3❭:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
    // ∣4❭:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
    // ∣5❭:     0.707107 +  0.000000 i  ==     **********           [ 0.500000 ]     --- [  0.00000 rad ]
    // ∣6❭:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
    // ∣7❭:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]

    // # wave function for qubits with ids (least to most significant): 0;1;2
    // ∣0❭:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
    // ∣1❭:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
    // ∣2❭:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
    // ∣3❭:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
    // ∣4❭:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
    // ∣5❭:     1.000000 +  0.000000 i  ==     ******************** [ 1.000000 ]     --- [  0.00000 rad ]
    // ∣6❭:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]
    // ∣7❭:     0.000000 +  0.000000 i  ==                          [ 0.000000 ]

    // Your random number is:
    // 5
    @EntryPoint()
    operation GenerateUniformState() : Int {
        using (qubits = Qubit[3]) {
            ApplyToEach(H, qubits);
            Message("The qubit register in a uniform superposition:");
            DumpMachine();
            mutable results = new Result[0];
            for (q in qubits) {
                Message(" ");
                set results += [M(q)];
                DumpMachine();
            }
            Message(" ");
            Message("Your random number is: ");
            return BoolArrayAsInt(ResultArrayAsBoolArray(results));
        }
    }
}
