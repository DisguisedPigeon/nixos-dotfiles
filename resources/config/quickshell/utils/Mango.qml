pragma Singleton

Singleton {
  id: mango

  property list<int> tags:

  Process {
      // the command it will run, every argument is its own string
      command: ["date"]

      // run the command immediately
      running: true

      // process the stdout stream using a StdioCollector
      // Use StdioCollector to retrieve the text the process sends
      // to stdout.
      stdout: StdioCollector {
        // Listen for the streamFinished signal, which is sent
        // when the process closes stdout or exits.
        onStreamFinished: {
          int.parse(this.text)
        }
      }
}
