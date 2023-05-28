void main() {
  performTasks();
}

void performTasks() async {
  task1();
  String data = await task2();
  task3(data);
}

void task1() {
  String result = 'task 1 data';
  print('$result complete');
}

Future<String> task2() async {
  late String result;
  await Future.delayed(const Duration(seconds: 5), () {
    result = 'task 2 data';
    print('Task 2 complete');
  });

  return result;
}

void task3(String textData) {
  String result = 'Task 3 data';
  print('$result complete with: $textData');
}
