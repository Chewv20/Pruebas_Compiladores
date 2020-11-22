defmodule Gittersnqcc do
  @moduledoc """
  Documentation for Nqcc.
  """
  @commands %{
    "-h" => "Prints this help", #help
	"-c" => "Shows compiler output", #Compiler
	"-l" => "Shows token list", #Lexer
	"-t" => "Display output in tree format", #Parser
	"-a" => "Shows assembler code" #Assembler
  }

  def main(args) do
    IO.inspect{args}
	case (args) do 
	["-h"] -> fhelp()
	["-c",file_name] -> fcompiler(file_name)
	["-a",file_name] -> fassembler(file_name)
	["-l",file_name] -> flexer(file_name)
	["-t",file_name] -> fparser(file_name)
#	_ -> ferror()
	end    
  end
  
  defp fhelp do 
  IO.puts("This is the users help:\n")
  @commands 
	|> Enum.map(fn {command, description} -> IO.puts(" #{command} -> #{description}")end)
  end
  
  defp  fcompiler (file_name) do 
  IO.puts("This is the compiler output:\n")
  assembly_path = String.replace_trailing(file_name,".c",".s")
  
  File.read!(file_name)
  |> Sanitizer.sanitize_source()
  |> Lexer.scan_words()
  |> Parser.parse_program()
  |> CodeGenerator.generate_code()
  |> Linker.generate_binary(assembly_path)
  end
  
  defp fassembler(file_name) do
  IO.puts("Code generared:")
  
  File.read!(file_name)
  |> Sanitizer.sanitize_source()
  |> Lexer.scan_words()
  |> Parser.parse_program()
  |> CodeGenerator.generate_code()
  end
 
 defp flexer(file_name) do
 File.read!(file_name)
  |> Sanitizer.sanitize_source()
  |> Lexer.scan_words()
  |> IO.inspect(label: "\nToken list")
 end
 
 defp fparser(file_name) do
 
   File.read!(file_name)
  |> Sanitizer.sanitize_source()
  |> Lexer.scan_words()
  |> Parser.parse_program()
  |> IO.inspect(label: "\nTree")
 end
 end
 