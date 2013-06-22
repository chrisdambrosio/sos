SuckerPunch.config do
  queue name: :test_queue, worker: TestWorker, workers: 2
end
