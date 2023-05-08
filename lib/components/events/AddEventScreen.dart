import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import '../../app/app.dart';

import 'package:stream_feed_flutter_core/stream_feed_flutter_core.dart';

class AddEventScreen extends StatefulWidget {
  @override
  _AddEventScreenState createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final _formKey = GlobalKey<FormState>();
  final _text = TextEditingController();

  File? _pickedFile;
  bool loading = false;

  final picker = ImagePicker();

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'xls', 'xlsx'],
      allowMultiple: false,
      withData: true,
      withReadStream: true,
    );

    if (result != null && result.files.isNotEmpty) {
      final pickedFile = result.files.first;
      setState(() {
        _pickedFile = File.fromRawPath(pickedFile.bytes!);
      });
    }
  }

  Future<void> _postEvent() async {
    if (_pickedFile == null) {
      context.removeAndShowSnackbar('Please select a file first');
      return;
    }

    if (!_formKey.currentState!.validate()) {
      context.removeAndShowSnackbar('Please enter a caption');
      return;
    }
    _setLoading(true);

    final client = context.appState.client;
    final bloc = FeedProvider.of(context).bloc;

    final attachmentFile = AttachmentFile(
      path: _pickedFile!.path,
      bytes: await _pickedFile!.readAsBytes(),
    );

    /* if (attachmentSizeInMB > maxFileSizeInMB) {
      _setLoading(false, shouldCallSetState: false);
      context.removeAndShowSnackbar(
          'File size should be less than $maxFileSizeInMB MB');
      return;
    }*/

    final imageUrl = await client.images.upload(attachmentFile);

    if (imageUrl != null && client.currentUser != null) {
      await bloc.onAddActivity(
        feedGroup: 'user',
        verb: 'create',
        object: 'event',
        data: {
          'description': _text.text,
          'attachment_url': imageUrl,
          'attachment_name': _pickedFile!,
          //'attachment_size': attachmentSizeInMB,
        },
      );
    }

    _setLoading(false, shouldCallSetState: false);
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  void _setLoading(bool value, {bool shouldCallSetState = true}) {
    if (shouldCallSetState) {
      setState(() {
        loading = value;
      });
    } else {
      loading = value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Event'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 16),
              Text(
                'Attach a file:',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              ElevatedButton.icon(
                onPressed: _pickFile,
                icon: Icon(Icons.attach_file),
                label: Text('Select File'),
              ),
              SizedBox(height: 16),
              if (_pickedFile != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Selected File:',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      _pickedFile!.path,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              SizedBox(height: 16),
              TextFormField(
                controller: _text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a caption';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Caption',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: loading ? null : _postEvent,
                child: loading
                    ? CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : Text('Post'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
