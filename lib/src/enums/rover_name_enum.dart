enum RoverNameEnum {
  curiosity(displayName: 'Curiosity'),
  opportunity(displayName: 'Opportunity'),
  spirit(displayName: 'Spirit');

  const RoverNameEnum({required this.displayName});

  final String displayName;
}
