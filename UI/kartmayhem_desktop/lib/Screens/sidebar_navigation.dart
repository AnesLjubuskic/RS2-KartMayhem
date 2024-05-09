import 'package:flutter/material.dart';

class SidebarNavigation extends StatelessWidget {
  final String selectedPage;
  final Function(String) onPageSelected;

  const SidebarNavigation({
    Key? key,
    required this.selectedPage,
    required this.onPageSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double containerWidth = screenWidth * 0.2; // 20% width parenta

    return Container(
      width: containerWidth,
      color: const Color(0xFFBC4849),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 20,
          ),
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                "KART MAYHEM",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SidebarButton(
            title: 'Staze',
            isSelected: selectedPage == 'staze',
            onTap: () => onPageSelected('staze'),
          ),
          const SizedBox(
            height: 50,
          ),
          SidebarButton(
            title: 'Rezervacije',
            isSelected: selectedPage == 'rezervacije',
            onTap: () => onPageSelected('rezervacije'),
          ),
          const SizedBox(
            height: 50,
          ),
          SidebarButton(
            title: 'Korisnici',
            isSelected: selectedPage == 'korisnici',
            onTap: () => onPageSelected('korisnici'),
          ),
          const SizedBox(
            height: 50,
          ),
          SidebarButton(
            title: 'Nagradi Korisnika',
            isSelected: selectedPage == 'nagradi',
            onTap: () => onPageSelected('nagradi'),
          ),
        ],
      ),
    );
  }
}

class SidebarButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const SidebarButton({
    Key? key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (_) {}, // Iskljuci hover efekat
      child: SizedBox(
        height: 50,
        child: FractionallySizedBox(
          widthFactor: 0.8,
          child: TextButton(
            onPressed: onTap,
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              backgroundColor:
                  MaterialStateProperty.resolveWith<Color>((states) {
                if (states.contains(MaterialState.disabled)) {
                  return Colors.grey;
                }
                return isSelected
                    ? const Color(0xFF870000)
                    : const Color(0xFFE8E8E8);
              }),
              foregroundColor:
                  MaterialStateProperty.resolveWith<Color>((states) {
                if (states.contains(MaterialState.disabled)) {
                  return Colors.black;
                }
                return isSelected ? Colors.white : Colors.black;
              }),
            ),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
