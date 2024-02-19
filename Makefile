# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: vdecleir <vdecleir@student.s19.be>         +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/02/12 18:08:57 by vdecleir          #+#    #+#              #
#    Updated: 2024/02/19 19:57:50 by vdecleir         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

GREEN = \033[0;32m
GREEN_BOLD = \033[1;32m
ORANGE = \033[0;38;5;214m
YELLOW = \033[0;33m
CLOSE = \033[0m

NAME = pipex

CC = cc

RM = rm -rf

CFLAGS = -Wall -Wextra -Werror

SRCS =	srcs/main.c \
		srcs/path.c \
		srcs/utils.c \
		pipes.c \

OBJ_DIR = objets

OBJS = $(addprefix $(OBJ_DIR)/, $(SRCS:.c=.o))

LIBFT = libft.a

LIBFT_PATH = ./libft

LIBFT_FLAG = $(LIBFT_PATH)/.libcompiled

PRINTF = libftprintf.a

PRINTF_PATH = ./ft_printf

PRINTF_FLAG = $(PRINTF_PATH)/.libcompiled

$(OBJ_DIR)/%.o: %.c
	@mkdir -p $(@D)
	@$(CC) $(CFLAGS) -c $< -o $@

all: $(LIBFT_FLAG) $(PRINTF_FLAG) $(NAME)

$(NAME): $(OBJS)
	@echo "$(ORANGE)Compiling Pipex...$(CLOSE)"
	@$(CC) $(OBJS) -L$(LIBFT_PATH) -lft -L$(PRINTF_PATH) -lftprintf -o $(NAME)
	@echo "$(GREEN_BOLD)The Pipex executable is ready.$(CLOSE)"

$(LIBFT_FLAG):
	@echo "$(ORANGE)Compiling Libft...$(CLOSE)"
	@make -s -C $(LIBFT_PATH)
	@echo "$(GREEN)Libft ready.$(CLOSE)"
	@touch $(LIBFT_FLAG)

$(PRINTF_FLAG):
	@echo "$(ORANGE)Compiling Ft_printf...$(CLOSE)"
	@make -s -C $(PRINTF_PATH)
	@echo "$(GREEN)Ft_printf ready.$(CLOSE)"
	@touch $(PRINTF_FLAG)

clean:
	@$(MAKE) clean -s -C $(LIBFT_PATH)
	@$(MAKE) clean -s -C $(PRINTF_PATH)
	@$(RM) $(OBJ_DIR)
	@echo "$(YELLOW)Objects correctly deleted.$(CLOSE)"

fclean: clean
	@$(RM) $(NAME) $(LIBFT_PATH)/$(LIBFT) $(LIBFT_FLAG)
	@$(RM) $(NAME) $(PRINTF_PATH)/$(PRINTF) $(PRINTF_FLAG)
	@echo "$(YELLOW)Executable file(s) correctly deleted.$(CLOSE)"

re: fclean all

.PHONY: all clean fclean re