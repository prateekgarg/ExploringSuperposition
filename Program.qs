namespace ExploringSuperposition {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Math;

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
    @EntryPoint()
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
}
