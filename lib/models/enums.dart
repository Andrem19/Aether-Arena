enum Target {
  Myself,
  AllAliveAnemy,
  SingleEnemyTarget,
  AllAliveAlly,
  SingleAlly,
  AllAliveInGame,
  RandomAllTarget,
  RandomEnemyTarget,
  None,
}

enum TypeOfAction {
  Heal,
  NormalDamage,
  PureDamage,
  DamageReduction,
  DestructibleArmour,
  UnpierceableArmour,
  FullInvulnerability,
  MeleeInvulnerability,
  RangedInvulnerability,
  PhysicalSkillsInvulnerability,
  ArcaneSkillsInvulnerability,
  MentalSkillsInvulnerability,
  PureSkillsInvulnerability,
  Stun,
  RemoveEnergy,
  StealEnergy,
  Reflect,
  Counter,
  PurgeAll,
  PurgeEnemyEffects,
  PurgeGoodEffects,
  Copy,
  Invisible,
  CannotReduceDamageOrBecomeInvulnerable,
  None,
}

enum EnergyEffect {
  Remove,
  Steel,
  Add,
  None,
}

enum Distance {
  Melee,
  Ranged,
  None,
}

enum SkillType {
  Physical,
  Arcane,
  Mental,
  Pure,
  None,
}

enum PersistenceType {
  Instant,
  Action,
  Control,
  None,
}

enum Energy {
  PHYSICAL,
  ARCANE,
  UNIQUE,
  WILLPOWER,
  RANDOM,
  NONE,
}
