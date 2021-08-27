
# ***** Creating EC2 instance  *****

resource "aws_instance" "ec2_task-5" {
  depends_on = [aws_vpc.vpc_task-5]
  ami                    = "ami-0c2b8ca1dad447f8a"
  instance_type          = "t2.micro"
  key_name               = "terraform_task"
  subnet_id              = aws_subnet.subnet_task-5.id
  vpc_security_group_ids = ["${aws_security_group.sg_task-5.id}"]
  associate_public_ip_address = true

  tags = {
    Name = "EC2 task5"
  }
}


# ***** Creating EBS volume   *****

resource "aws_ebs_volume" "volume_task-5" {
	availability_zone = aws_instance.ec2_task-5.availability_zone
	size = 1
	tags = {
	  Name = "my EBS vol for task-5"
   }
}


# *****  Attaching Volume  *****

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.volume_task-5.id
  instance_id = aws_instance.ec2_task-5.id
}



# *****  Connect to the instance using ssh  *****

resource "null_resource" "skills" {
	depends_on = [aws_instance.ec2_task-5]
connection {
	type = "ssh"
	user = "ec2-user"
	private_key = file("C:/Users/ANUJA KUMARI/Downloads/terraform_task.pem")
	host = aws_instance.ec2_task-5.public_ip   
 }


provisioner "remote-exec" {
	inline = [
      "sudo yum install httpd -y",
 	    "sudo systemctl start httpd",
	    "sudo systemctl enable httpd",
	    "sudo yum install git -y",
 	    "sudo git clone https://github.com/Anujakumari/Launching_Webserver_using_TERRAFORM.git  /var/www/html", 
	    "sudo systemctl restart httpd"  
    ]
 }
  
}

# Print Output 

output "public_ip" {
  value = aws_instance.ec2_task-5.public_ip
}