import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/models/task.dart';

void main() {
  test('Task model creation test', () {
    final now = DateTime.now();
    final task = Task(id: '1', title: 'Test Task', createdAt: now);

    expect(task.id, '1');
    expect(task.title, 'Test Task');
    expect(task.isCompleted, false);
    expect(task.createdAt, now);
  });
}
