module "key_pair" {
  source = "terraform-aws-modules/key-pair/aws"

  key_name   = "assignment"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDcuhcfckWYA6Dk88RgFyfh1Jq7L85NCLVv5Na4inS68MAA4mfO9n2sDIWZsjbRNvImWa8XbVMUYjRwnjbt80QlKXbgkQe/yj666lY+bVC7obgZzQKfBjXFg+o4UmI33oowc9HdilaTTN92SPyGUTwmcZxm7TEQfGncN7Q6cv93REmDWmYqZE3iYPhtTpa37/qHHTtNEO88gP/lmAC0e918twqenYCmXdk2t0bWsZZ8YWlAs//55h7k48JaheiF1n+h1d6T7m6E8UlbNYjEVVN/N5cZSkUwbTnDtZu+Yt4OQKp13CTHe4lraoMAPyOnBfKfrsjaY4aY+/3fn3kr70AtY7X4BrtVRB18uF01hXPfn2W1MWCQEk4Jcl1bg2wxoDeyatU2JHjKnHNY8I7GvObHPUHK2Il4VHgndiTEUTKOg1kt8nLkroM96B33045ipwNvhC8goN7aMmUgiUZipx7wZmxFPTaiK/kgVPicJMMVVMJaIFWbGSPapdh1PCfkdlc= dipeshgarg@192.168.1.3"
}
