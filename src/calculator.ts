export type Operation = "add" | "subtract" | "multiply" | "divide";

export const PREMIUM_OPERATIONS: Operation[] = ["multiply", "divide"];

export function isPremium(op: Operation): boolean {
  return PREMIUM_OPERATIONS.includes(op);
}

export function calculate(a: number, b: number, op: Operation): number {
  if (isPremium(op)) throw new Error("premium");
  if (op === "add") return a + b;
  if (op === "subtract") return a - b;
  throw new Error("unknown operation");
}
