# file client.rb

require 'socket'

if ARGV.length != 2
  puts "Ingresar argumentos de la IP del servidor y el numero del puerto."
  exit(0)
else
  ip_servidor = ARGV[0]
  puerto_servicio = ARGV[1]
  ARGV.clear
end

begin
  puts "Conectando al servidor #{ip_servidor} en el puerto #{puerto_servicio} ..."
  servidor = TCPSocket.open(ip_servidor, puerto_servicio)
  puts "Conectado al servidor #{ip_servidor} en el puerto #{puerto_servicio}."
rescue
  puts "No se pudo conectar al Servidor."
  exit(0)
end

begin
  while mensaje_al_servidor = gets.chomp
    servidor.puts mensaje_al_servidor
    mensaje_del_servidor = servidor.gets
    puts  "Mensaje del servidor: #{mensaje_del_servidor}"
    break if mensaje_al_servidor =~ /finalizar()/
  end
rescue Interrupt
  puts "\nSe interrumpio el cliente con un Control_C."
end
puts "Cerrando conexion con el servidor ..."
servidor.close
puts "Conexion con el servidor cerrado."
