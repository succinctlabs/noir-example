# noir-succinct-template
Example Noir Circuit for use in [Succinct's Proving Service](alpha.succinct.xyz).

This repostiroy contains a Noir contract and implements the adaptor commands in [succinct.json](succinct.json) for making `nargo prove` compatible with [Succinct](succinct.xyz)'s proving service.

To save gas costs, Succinct expects circuits to [expose inputs and outputs as a single hash](https://github.com/succinctlabs/succinctx/blob/main/contracts/src/interfaces/IFunctionVerifier.sol).  (Documentation for that is coming soon).

In our [input conversion script](convert_input.sh) we convert the Noir Prover.toml to conform to the Succinct Platform's expected `input.json` format and
similarly our [output conversion script](convert_output.sh) we conver the `Verifier.toml` output into Succinct's expected `output.json`.
