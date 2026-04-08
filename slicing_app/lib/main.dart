import 'package:flutter/material.dart';

void main() {
  runApp(const HardwareMonitorApp());
}

class HardwareMonitorApp extends StatelessWidget {
  const HardwareMonitorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0B0E14),
      ),
      home: const HardwareDashboard(),
    );
  }
}

class HardwareDashboard extends StatelessWidget {
  const HardwareDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("System Resources", style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(icon: const Icon(Icons.refresh, color: Colors.cyanAccent), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // RAM SECTION
            const SectionHeader(title: "Memory (RAM)", subtitle: "DDR5 5200MHz"),
            const SizedBox(height: 15),
            const ResourceCard(
              label: "Total Used",
              value: "12.4 GB",
              total: "16 GB",
              percent: 0.77,
              accentColor: Colors.cyanAccent,
              icon: Icons.memory_rounded,
            ),
            
            const SizedBox(height: 35),

            // SSD SECTION
            const SectionHeader(title: "Storage (SSD)", subtitle: "NVMe Gen4 x4"),
            const SizedBox(height: 15),
            const ResourceCard(
              label: "Local Disk (C:)",
              value: "412 GB",
              total: "512 GB",
              percent: 0.80,
              accentColor: Colors.purpleAccent,
              icon: Icons.storage_rounded,
            ),
            const SizedBox(height: 15),
            const ResourceCard(
              label: "Games (D:)",
              value: "890 GB",
              total: "1 TB",
              percent: 0.89,
              accentColor: Colors.orangeAccent,
              icon: Icons.album_outlined,
            ),

            const SizedBox(height: 30),
            
            // Health Status Row
            Row(
              children: const [
                Expanded(child: HealthBadge(label: "Temp", value: "42°C", color: Colors.greenAccent)),
                SizedBox(width: 15),
                Expanded(child: HealthBadge(label: "Status", value: "Excellent", color: Colors.blueAccent)),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  const SectionHeader({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
        Text(subtitle, style: const TextStyle(fontSize: 14, color: Colors.white38)),
      ],
    );
  }
}

class ResourceCard extends StatelessWidget {
  final String label;
  final String value;
  final String total;
  final double percent;
  final Color accentColor;
  final IconData icon;

  const ResourceCard({
    super.key,
    required this.label,
    required this.value,
    required this.total,
    required this.percent,
    required this.accentColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1F29),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: accentColor.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                child: Icon(icon, color: accentColor),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text("$value / $total", style: const TextStyle(color: Colors.white54, fontSize: 13)),
                  ],
                ),
              ),
              Text("${(percent * 100).toInt()}%", style: TextStyle(color: accentColor, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: percent,
              minHeight: 8,
              backgroundColor: Colors.black26,
              color: accentColor,
            ),
          ),
        ],
      ),
    );
  }
}

class HealthBadge extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const HealthBadge({super.key, required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1F29),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Text(label, style: const TextStyle(color: Colors.white38, fontSize: 12)),
          const SizedBox(height: 5),
          Text(value, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 18)),
        ],
      ),
    );
  }
}