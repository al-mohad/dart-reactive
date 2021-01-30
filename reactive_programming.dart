// 2. Creating and Subscribing to Streams
import 'dart:async';

Stream<int> getNumbers() async* {
  for (int i = 1; i < 10; i++) {
    yield i;
    await Future.delayed(Duration(seconds: 1));
  }
}

// 2. Getting data from a Stream
Stream<int> getNumbersException() async* {
  for (int i = 1; i < 3; i++) {
    yield i;
    await Future.delayed(Duration(seconds: 1));
    if (i == 2) {
      throw Exception();
    }
  }
}

void listen() {
  // getNumbers().listen((data) {
  //   print(data);
  // });

  // getNumbersException().listen((data) {
  //   print(data);
  // }).onError((error) {
  //   print('an error occured');
  // });

  var sum = 0;
  getNumbers().listen((data) {
    sum += data;
  }).onDone(() {
    print(sum);
  });
}

void awaitFor() async {
  var sum = 0;
  await for (var number in getNumbers()) {
    sum += number;
    print(number);
  }
  print('Total: $sum');
}

void isEmpty() async {
  if (await getNumbers().isEmpty) {
    print('Stream is empty');
  } else {
    print('Stream is not empty');
  }
}

void first() async {
  print('First item in the stream is: ');
  print(await getNumbers().first);
}

void last() async {
  print('Last item in the stream is: ');
  print(await getNumbers().last);
}

void length() async {
  print('Length of item in the stream is: ');
  print(await getNumbers().length);
}

void single() async {
  print('Single item in the stream is: ');
  print(await getNumbers().single);
}

void any() async {
  if (await getNumbers().any((int i) => i == 3)) {
    print('There is a number equal to 3');
  } else {
    print('There is no number equal to 3');
  }
}

void contains() async {
  if (await getNumbers().contains(3)) {
    print('There is a number equal to 3');
  } else {
    print('There is no number equal to 3');
  }
}

void elementAt() async {
  print(await getNumbers().elementAt(2));
}

void firstWhere() async {
  print(await getNumbers().firstWhere((i) => i > 1));
}

void join() async {
  print(await getNumbers().join(', '));
}

void lastWhere() async {
  print(await getNumbers().lastWhere((i) => i > 1));
}

void singleWhere() async {
  print(await getNumbers().singleWhere((i) => i <= 1));
}

//  3. Stream Operators
void expand() async {
  getNumbers().expand((data) => [data, data * 10]).listen((item) {
    print(item);
  });
}

void map() async {
  getNumbers().map((i) => i * 10).listen((item) {
    print(item);
  });
}

void skip() async {
  getNumbers().skip(2).listen((item) {
    print(item);
  });
}

void skipWhile() async {
  getNumbers().skipWhile((i) {
    return i < 5;
  }).listen((item) {
    print(item);
  });
}

void take() async {
  getNumbers().take(2).listen((data) {
    print(data);
  });
}

void takeWhile() async {
  getNumbers().takeWhile((item) => item % 2 != 0).listen((data) {
    print(data);
  });
}

void where() async {
  getNumbers().where((item) => item % 2 != 0).listen((data) {
    print(data);
  });
}

void distinct() async {
  getNumbersDuplicate().distinct().listen((data) {
    print(data);
  });
}

void chaining() async {
  getNumbersDuplicate()
      .distinct()
      .map((item) => item * 10)
      .where((item) => item != 20)
      .listen((data) {
    print(data);
  });
}

// Stream
Stream<int> getNumbersDuplicate() async* {
  for (var i = 1; i <= 3; i++) {
    yield i;
    yield i;
    await Future.delayed(Duration(seconds: 1));
  }
}

// 4. Error handling
Stream<int> getNumbersError() async* {
  for (var i = 1; i <= 3; i++) {
    yield i;
    await Future.delayed(Duration(seconds: 3));
    if (i == 2) {
      throw Exception();
    }
  }
}

Stream<int> getNumbersTimeout() async* {
  for (var i = 1; i <= 3; i++) {
    yield i;
    await Future.delayed(Duration(seconds: 3));
    if (i == 2) {
      throw Exception();
    }
  }
}

void handleError() {
  getNumbersError().handleError((error) {
    print(error);
  }).listen(print);
}

void timeout() async {
  getNumbersTimeout().timeout(Duration(seconds: 3)).listen((event) {
    print(event);
  });
}

// 5. Stream Controller
void addDataToStream() {
  _controller.sink.add('some data');
}

StreamController<String> _controller = StreamController<String>.broadcast();
Stream<String> get out => _controller.stream;
// void main() {
// Lesson 1
// getNumbers().listen((data) {
//   print(data);
// });

// getNumbersException().listen((data) {
//   print(data);
// });

// Lesson 2
// listen();
// awaitFor();
// isEmpty();
// first();
// last();
// length();
// single();
// any();
// containts();
// elementAt();
// firstWhere();
// join();
// lastWhere();

// Lesson 3
// expand();
// map();
// skip();
// skipWhile();
// take();
// takeWhile();
// where();
// distinct();
// chaining();

// Lesson 4
// handleError();
// timeout();

// Lesson 5
//   out.listen((event) {
//     print(event);
//   });

//   out.listen((event) {
//     print(event.replaceAll('a', 'e'));
//   });

//   addDataToStream();
// }
