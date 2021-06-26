import subprocess
def aws():
	output1 = subprocess.getoutput("terraform init");
	print(output1)

	output2 = subprocess.getoutput("terraform apply --auto-approve");
	print(output2)
#aws()