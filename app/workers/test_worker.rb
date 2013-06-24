class TestWorker
  include SuckerPunch::Worker

  def perform
    puts "test worker output"
    AlertWorker.new.perform
  end
end
