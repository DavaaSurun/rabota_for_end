import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'AddEventScreen.dart';
import '../../app/state/models/models.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  List<EventData> _events = [
    EventData(
      title: 'Концерт группы "L\'One"',
      description: 'будет, но вряд ли',
      date: DateTime.now().add(Duration(days: 5)),
      location: 'Олимпийский проспект, 16',
      region: 'Москва',
      city: 'Москва',
      prize: 'много ничего',
      conditions: 'билет',
    ),
    EventData(
      title: 'Выставка "Живопись XIX века"',
      description: 'будет, но вряд ли',
      date: DateTime.now().subtract(Duration(days: 2)),
      location: 'Невский проспект, 179',
      region: 'Ленинградская область',
      city: 'Санкт-Петербург',
      prize: 'много ничего',
      conditions: 'билет',
    ),
    EventData(
      title: 'Фестиваль еды "Вкусный город"',
      description: 'будет, но вряд ли',
      date: DateTime.now().add(Duration(days: 12)),
      location: 'Тверская площадь, 3',
      region: 'Московская область',
      city: 'Москва',
      prize: 'много ничего',
      conditions: 'билет',
    ),
  ];

  String _selectedSortOption = 'Date';

  void _sortEvents(String option) {
    setState(() {
      _selectedSortOption = option;
      if (option == 'Date') {
        _events.sort((a, b) => a.date.compareTo(b.date));
      } else if (option == 'Location') {
        _events.sort((a, b) => a.location.compareTo(b.location));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Мероприятия'),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Сортировать по:'),
              DropdownButton<String>(
                value: _selectedSortOption,
                items: <String>['Date', 'Location'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (option) {
                  _sortEvents(option!);
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _events.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: ListTile(
                  title: Text(_events[index].title),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Дата: ${DateFormat('dd.MM.yyyy').format(_events[index].date)}',
                      ),
                      Text('Место: ${_events[index].location}'),
                      Text('Регион: ${_events[index].region}'),
                      Text('Город: ${_events[index].city}'),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ]),
      bottomNavigationBar: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => AddEventScreen(),
          ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
