# noir-succinct-template
Example Noir Circuit for use in Succinct's Proving Service

This implements the [succinct.json](succinct.json) commands expected by [Succinct](alpha.succinct.xyz) to use their proving service.

To save gas costs, Succinct expects circuits to expose inputs and outputs as a single hash.  (Documentation for that is coming soon).

In our [input conversion script](convert_input.sh) we convert the Noir Prover.toml to conform to the Succint Platform's expected `input.json` format and
similarly our [output conversion script](convert_output.sh) we conver the `Verifier.toml` output into Succint's expected `output.json`.
