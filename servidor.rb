# file server.rb

require 'socket'

if ARGV.length != 1
  puts "Ingresar argumento del numero del puerto."
  exit(0)
else
  puerto = ARGV[0]
  ARGV.clear
end

puts "Configurando servicio en el puerto #{puerto} ..."
servidor = TCPServer.new puerto
puts "Servicio en el puerto #{puerto} configurado."

begin
loop do
    print("Esperando la conexion de un cliente ...\n")
    cliente = servidor.accept
    print(cliente, " aceptado.\n")
    begin
      while cliente_mensaje = cliente.gets
        break if cliente_mensaje =~ /finalizar()/
        puts  "Mensaje del cliente: #{cliente_mensaje}"
        cliente.puts "Hola cliente, el servidor recibio su mensaje #{cliente_mensaje}"
      end
    rescue Interrupt
      puts "\nSe interrunpio el cliente con un Control_C."
    end
    puts "Cerrando la conexion con el cliente ..."
    cliente.puts "Cerrando la conexion, Adios!"
    cliente.close
    print(cliente, " cerrado\n")
end
rescue Interrupt
  puts "\nSe interrumpio el servidor con un Control_C."
end
puts "Cerrando el servicio ..."
servidor.close
puts "Servicio cerrado, Adios!\n"
