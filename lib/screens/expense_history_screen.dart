import 'package:flutter/material.dart';

class ExpenseHistoryScreen extends StatelessWidget {
  const ExpenseHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF4CAF50);

    return Scaffold(
      backgroundColor: const Color(0xffF7F9FC),

      appBar: AppBar(
        title: const Text("Expense History"),
        centerTitle: true,
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            TextField(
              decoration: InputDecoration(
                hintText: "Search expenses...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView(
                children: [

                  expenseCard(
                    icon: Icons.restaurant,
                    title: "Dinner",
                    subtitle: "Paid by Muhammad Hamza",
                    amount: "Rs 1200",
                    color: Colors.green,
                  ),

                  expenseCard(
                    icon: Icons.shopping_bag,
                    title: "Shopping",
                    subtitle: "Paid by Ali",
                    amount: "Rs 850",
                    color: Colors.orange,
                  ),

                  expenseCard(
                    icon: Icons.local_taxi,
                    title: "Taxi",
                    subtitle: "Paid by Ahmed",
                    amount: "Rs 500",
                    color: Colors.blue,
                  ),

                  expenseCard(
                    icon: Icons.movie,
                    title: "Movie",
                    subtitle: "Paid by Usman",
                    amount: "Rs 1500",
                    color: Colors.purple,
                  ),

                  expenseCard(
                    icon: Icons.fastfood,
                    title: "Lunch",
                    subtitle: "Paid by Ali",
                    amount: "Rs 650",
                    color: Colors.red,
                  ),

                  expenseCard(
                    icon: Icons.flight,
                    title: "Trip",
                    subtitle: "Paid by Muhammad Hamza",
                    amount: "Rs 7000",
                    color: Colors.teal,
                  ),

                  expenseCard(
                    icon: Icons.coffee,
                    title: "Coffee",
                    subtitle: "Paid by Ahmed",
                    amount: "Rs 300",
                    color: Colors.brown,
                  ),

                  expenseCard(
                    icon: Icons.receipt_long,
                    title: "Bills",
                    subtitle: "Paid by Usman",
                    amount: "Rs 2100",
                    color: Colors.indigo,
                  ),                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget expenseCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required String amount,
    required Color color,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(15),

        leading: CircleAvatar(
          radius: 28,
          backgroundColor: color.withOpacity(0.15),
          child: Icon(
            icon,
            color: color,
            size: 28,
          ),
        ),

        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),

        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            subtitle,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
        ),

        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              amount,
              style: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 8),

            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.blue,
                    size: 20,
                  ),
                  onPressed: () {},
                ),

                IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 20,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}