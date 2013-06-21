class TestWorker
  include SuckerPunch::Worker

  def perform
    puts "test worker output"
  end
end
