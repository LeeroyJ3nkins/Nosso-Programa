# Nome do programa final
TARGET = app_soviet

# Compilador e flags
CC = gcc
CFLAGS = -Wall -g

# Pega todos os arquivos .c da pasta automaticamente
SRCS = $(wildcard *.c)

# Cria a lista de objetos .o
OBJS = $(SRCS:.c=.o)

# Regra principal: compilar tudo
all: $(TARGET)

# Linkagem (juntar as peças)
$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) -o $(TARGET) $(OBJS)

# Compilação individual
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# Regra para rodar
run: $(TARGET)
	./$(TARGET)

# Regra para limpar sujeira
clean:
	rm -f $(OBJS) $(TARGET)
