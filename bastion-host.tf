resource "" "name" {
  ami                    = lookup(var.AMI, var.AWS_REGION)
  instance_type          = "t2.micro"
  public_key             = aws_key_pair.key.key_name
  subnet_id              = module.vpc.public_subnets[0]
  count                  = var.INSTANCE_COUNT
  vpc_security_group_ids = [aws_security_group.bastion-sg.id]

  tags = {
    Name    = "vprofile-bastion"
    Project = "vprofile"
  }

  provisioner "file" {
    content     = templatefile("templates/db-deploy-tmpl", { rds-endpoint = aws_db_instance.rds.address, dbuser = vars.DB_USER, dbpass = vars.DB_PASS })
    destination = "tmp/vprofile-dbdeploy.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x tmp/vprofile-dbdeploy.sh",
      "sudo tmp/vprofile-dbdeploy.sh"
    ]
  }
  connection {
    user        = var.USERNAME
    private_key = file(var.PRIV_KEY_PATH)
    host        = self.public_ip
  }

  depends_on = [aws_db_instance.rds]
}