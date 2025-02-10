class FileDestroyerCallback
  # def self.after_commit(file)
  #   if File.exist?(file.filepath)
  #     File.delete(file.filepath)
  #     puts "File #{file.filepath} deleted successfully!"
  #   else
  #     puts "File #{file.filepath} does not exist!"
  #   end
  # end

  def after_commit(file)
    if File.exist?(file.filepath)
      File.delete(file.filepath)
      puts "File #{file.filepath} deleted successfully!"
    else
      puts "File #{file.filepath} does not exist!"
    end
  end
end
