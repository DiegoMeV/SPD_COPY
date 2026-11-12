interface EntityRecord {
  id: number;
  code: string;
  name: string;
  is_active: boolean;
  start_date: string;
  end_date: string;
}

interface EntityVars {}

export type { EntityRecord, EntityVars };
