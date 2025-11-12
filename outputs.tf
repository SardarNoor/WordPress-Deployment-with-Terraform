output "wordpress_public_ip" {
  description = "Public IP of WordPress instance"
  value       = aws_instance.wordpress.public_ip
}

output "mysql_private_ip" {
  description = "Private IP of MySQL instance"
  value       = aws_instance.mysql.private_ip
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnet_ids" {
  value = {
    public  = aws_subnet.public.id
    private = aws_subnet.private.id
  }
}
