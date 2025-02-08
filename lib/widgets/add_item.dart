import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddMedicineScreen extends StatefulWidget {
  const AddMedicineScreen({super.key});

  @override
  _AddMedicineScreenState createState() => _AddMedicineScreenState();
}

class _AddMedicineScreenState extends State<AddMedicineScreen> {
  int selectedCompartment = 1;
  Color selectedColor = Colors.pink[100]!;
  String selectedType = 'Tablet';
  double quantity = 0.5;
  double totalCount = 1;
  String frequency = 'Everyday';
  String timesPerDay = 'Three Time';
  List<bool> mealTimings = [true, false, false];
  // Before, After, Before Sleep

  DateTime today = DateTime.now();
  DateTime? endDate;

  void increment() {
    setState(() {
      quantity += 0.5;
    });
  }

  void decrement() {
    setState(() {
      if (quantity > 0.5) {
        quantity -= 0.5;
      }
    });
  }

  Future<void> pickEndDate() async {
    try {
      DateTime? picked = await showDatePicker(
        context: context,
        initialDate: today,
        firstDate: today,
        lastDate: DateTime(2100),
      );
      if (picked != null && picked != endDate) {
        setState(() {
          endDate = picked;
        });
      }
    } catch (e) {
      // Handle any exceptions that might occur
      print('Error picking end date: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        title: Text('Add Medicines',
            style: TextStyle(color: Colors.black, fontSize: 18)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search Medicine Name',
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: Icon(Icons.mic),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
              ),
            ),

            SizedBox(height: 24),

            // Compartments
            Text('Compartment',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            SizedBox(height: 8),
            Row(
              children: List.generate(
                6,
                (index) => Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: InkWell(
                    onTap: () =>
                        setState(() => selectedCompartment = index + 1),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: selectedCompartment == index + 1
                            ? Colors.blue[100]
                            : Colors.white,
                        border: Border.all(
                            color: selectedCompartment == index + 1
                                ? Colors.blue
                                : Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text('${index + 1}',
                            style: TextStyle(
                                color: selectedCompartment == index + 1
                                    ? Colors.blue
                                    : Colors.grey)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 24),

            // Color Selection
            Text('Colour',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            SizedBox(height: 8),
            Row(
              children: [
                Colors.pink[100],
                Colors.purple[100],
                Colors.red[100],
                Colors.green[100],
                Colors.orange[100],
                Colors.blue[100],
                // Colors.yellow[100],
              ]
                  .map(
                    (color) => Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: InkWell(
                        onTap: () => setState(() => selectedColor = color!),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: selectedColor == color
                                    ? Colors.blue
                                    : Colors.transparent,
                                width: 2),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            SizedBox(height: 24),

            // Medicine Type
            Text('Type',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            SizedBox(height: 8),
            Row(
              children: [
                _buildTypeOption('Tablet', Icons.circle),
                _buildTypeOption('Capsule', Icons.medication),
                _buildTypeOption('Cream', Icons.sanitizer),
                _buildTypeOption('Liquid', Icons.local_drink),
              ],
            ),
            SizedBox(height: 24),

            // Quantity
            Text('Quantity',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            SizedBox(height: 12),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 200,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(255, 66, 66, 67)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "Take ${quantity.toString()} Pill",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    IconButton(
                      onPressed: decrement,
                      icon: const Icon(Icons.remove, color: Colors.blue),
                    ),
                    IconButton(
                      onPressed: increment,
                      icon: const Icon(Icons.add, color: Colors.blue),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 24),

            // Total Count Slider
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Count',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                Text('${totalCount.round()}', style: TextStyle(fontSize: 16)),
              ],
            ),
            Slider(
              value: totalCount,
              min: 1,
              max: 100,
              onChanged: (value) => setState(() => totalCount = value),
            ),
            SizedBox(height: 24),

            // Date Selection
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Set Date",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {}, // Today is fixed, no picker needed
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 16),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Today", style: TextStyle(fontSize: 16)),
                                Icon(Icons.chevron_right, color: Colors.grey),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: GestureDetector(
                          onTap: pickEndDate,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 16),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  endDate != null
                                      ? DateFormat('MMM dd, yyyy')
                                          .format(endDate!)
                                      : "End Date",
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const Icon(Icons.chevron_right,
                                    color: Colors.grey),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 24),

            // Frequency
            Text('Frequency of Days',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            SizedBox(height: 8),
            _buildDropdown('Everyday'),
            SizedBox(height: 24),

            // Times per Day
            Text('How many times a Day',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            SizedBox(height: 8),
            _buildDropdown('Three Time'),
            SizedBox(height: 24),

            // Dose Timings
            ...List.generate(
              3,
              (index) => Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: _buildDoseTime('Dose ${index + 1}'),
              ),
            ),

            // Meal Timings
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildMealTiming('Before Food', 0),
                _buildMealTiming('After Food', 1),
                _buildMealTiming('Before Sleep', 2),
              ],
            ),
            SizedBox(height: 24),

            // Add Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text('Add'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeOption(String type, IconData icon) {
    final isSelected = selectedType == type;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedType = type),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue[100] : Colors.grey[100],
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: isSelected ? Colors.blue : Colors.grey),
            ),
            SizedBox(height: 4),
            Text(type,
                style:
                    TextStyle(color: isSelected ? Colors.blue : Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantityButton(IconData icon) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: Colors.white),
    );
  }

  Widget _buildDateButton(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text),
          Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildDropdown(String value) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(value),
          Icon(Icons.expand_more, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildDoseTime(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.access_time, color: Colors.grey),
              SizedBox(width: 8),
              Text(text),
            ],
          ),
          Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildMealTiming(String text, int index) {
    return GestureDetector(
      onTap: () => setState(() => mealTimings[index] = !mealTimings[index]),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: mealTimings[index] ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: mealTimings[index] ? Colors.blue : Colors.grey[300]!),
        ),
        child: Text(text,
            style: TextStyle(
                color: mealTimings[index] ? Colors.white : Colors.grey)),
      ),
    );
  }
}
