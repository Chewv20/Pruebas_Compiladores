defmodule Linker do
  def generate_binary(assembler, assembly_path) do
    assembly_file_name = Path.basename(assembly_path)     #return_2.s
    binary_file_name = Path.basename(assembly_path, ".s") #return_2
    output_dir_name = Path.dirname(assembly_path)         #examples
    assembly_path = output_dir_name <> "/" <> assembly_file_name #examples/return_2.s

    File.write!(assembly_path, assembler)
    System.cmd("gcc ", [assembly_file_name, " -o #{binary_file_name}"], cd: output_dir_name)
    #File.rm!(assembly_path)
  end
end

