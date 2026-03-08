# keypair 
resource "aws_key_pair" "Deployer"{
    key_name= "terra-key-ec2"
    public_key =file("terra-ec2-key.pub")
}

# VPC security Groups

resource "aws_vpc" "main"{
    cidr_block = "10.0.0.0/16"
    tags ={
        name = "terra_vpc"
    } 

}

resource aws_subnet "my_subnet"{
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.1.0/24"

    map_public_ip_on_launch = true
        tags = {
         name = "public-subnet"
     }
 }
   
   resource "aws_internet_gateway" "Ig"{
    vpc_id = aws_vpc.main.id
    tags = {
        name = "Vpc-internet-gateway"
    }
   }

   resource "aws_route_table" "RT"{
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.Ig.id
    }

   }

   resource "aws_route_table_association" "assoc" {
     subnet_id = aws_subnet.my_subnet.id
     route_table_id = aws_route_table.RT.id
   }
   


resource "aws_security_group" "my_security_group"{
    name = "my-Sg"
    vpc_id = aws_vpc.main.id
   


#inbound rules
    ingress{
         from_port =22
        to_port = 22
        cidr_blocks = ["0.0.0.0/0" ]
        protocol = "tcp"
        description = "SSh port are now open"
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]

    }
#outbound rules
    egress{
       from_port =0
       to_port = 0
       protocol ="-1"
       cidr_blocks = ["0.0.0.0/0"]  
    }
}
# ec2 instance

resource "aws_instance" "TerraInstance"{
    key_name = aws_key_pair.Deployer.key_name
    subnet_id = aws_subnet.my_subnet.id
    vpc_security_group_ids = [aws_security_group.my_security_group.id]
    
    associate_public_ip_address = true


    instance_type = var.aws_instance_type
    ami = var.ec2_ami_id
    user_data = file("install-nginx.sh")
    

    root_block_device{
        volume_size =  var.block_store_size
        volume_type = "gp3"
    }
    tags = {
        name= "terra-sever"
    }
}




