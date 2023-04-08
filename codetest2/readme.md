
# Challenge #2

# This folder containes the code in powershell that will query the meta data of an instance in Azure.

Use get-metadata.ps1 script and execute in a VM in Azure and it will provide the output of the instance metadata.

I have also attached the output file - metadata-output.json.

It exposes the important metadata for the VM instance, including compute, network, and storage.

# To retrive a particular data key need to use get-metadata-key.ps1 and the output is in text format in file metadata-datakey-output.txt