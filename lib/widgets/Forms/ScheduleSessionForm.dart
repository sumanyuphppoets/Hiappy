import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hiappy/widgets/CustomInput.dart';


class ScheduleSessionForm extends StatefulWidget {
  final TextEditingController topicController;
  final TextEditingController mentorController;
  final TextEditingController dateController;
  final TextEditingController timeController;
  final String selectedAmPm;
  final String? selectedDuration;
  final void Function(
    String topic,
    String mentor,
    String date,
    String time,
    String amPm,
    String duration,
  ) onSubmit;

  const ScheduleSessionForm({
    super.key,
    required this.topicController,
    required this.mentorController,
    required this.dateController,
    required this.timeController,
    required this.selectedAmPm,
    required this.selectedDuration,
    required this.onSubmit,
  });

  @override
  _ScheduleSessionFormState createState() => _ScheduleSessionFormState();
}

class _ScheduleSessionFormState extends State<ScheduleSessionForm> {
  final _formKey = GlobalKey<FormState>();
  late String selectedAmPm;
  String? selectedDuration;

  final List<String> durations = [
    '5 - 10 mins',
    '10 - 15 mins',
    '15 - 30 mins',
  ];

  @override
  void initState() {
    super.initState();
    selectedAmPm = widget.selectedAmPm;
    selectedDuration = widget.selectedDuration;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Create a session schedule", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 20),
              CustomInput(
                hint: 'Topics of meeting',
                iconAsset: 'assets/icons/MettingTopic.svg',
                controller: widget.topicController,
                validator: (value) => value == null || value.isEmpty ? 'Please enter a topic' : null,
              ),
              CustomInput(
                hint: 'Doctor/Mentor name',
                iconAsset: 'assets/icons/Doctoricon.svg',
                controller: widget.mentorController,
                validator: (value) => value == null || value.isEmpty ? 'Please enter a name' : null,
              ),
              GestureDetector(
                onTap: _pickDate,
                child: AbsorbPointer(
                  child: CustomInput(
                    hint: 'Select Date',
                    iconAsset: 'assets/icons/DateSelect.svg',
                    controller: widget.dateController,
                    validator: (value) => value == null || value.isEmpty ? 'Please select a date' : null,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: _pickTime,
                      child: AbsorbPointer(
                        child: CustomInput(
                          hint: 'Select Time',
                          iconAsset: 'assets/icons/Time.svg',
                          controller: widget.timeController,
                          validator: (value) => value == null || value.isEmpty ? 'Please select time' : null,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: DropdownButton<String>(
                      value: selectedAmPm,
                      underline: SizedBox(),
                      onChanged: (val) => setState(() => selectedAmPm = val!),
                      items: ["AM", "PM"]
                          .map((e) => DropdownMenuItem(child: Text(e), value: e))
                          .toList(),
                    ),
                  ),
                ],
              ),
              DropdownButtonFormField<String>(
                value: selectedDuration,
                items: durations
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) => setState(() => selectedDuration = value),
                decoration: InputDecoration(
                  labelText: "Select Duration",
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset('assets/icons/video_icon.svg', height: 20, width: 20),
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                ),
                validator: (value) => value == null ? 'Please select a duration' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pop(context); // Close the modal
                    widget.onSubmit(
                      widget.topicController.text,
                      widget.mentorController.text,
                      widget.dateController.text,
                      widget.timeController.text,
                      selectedAmPm,
                      selectedDuration!,
                    );
                  }
                },
                child: Text("Create a schedule session"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      widget.dateController.text = "${picked.day}/${picked.month}/${picked.year}";
    }
  }

  Future<void> _pickTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      widget.timeController.text = picked.format(context);
    }
  }
}
