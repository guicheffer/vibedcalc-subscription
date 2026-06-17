import { describe, it, expect } from "vitest";
import { calculate, isPremium } from "../src/calculator.js";

describe("calculator", () => {
  it("adds two numbers", () => {
    expect(calculate(2, 3, "add")).toBe(5);
  });

  it("subtracts two numbers", () => {
    expect(calculate(10, 4, "subtract")).toBe(6);
  });

  it("throws for multiply", () => {
    expect(() => calculate(2, 3, "multiply")).toThrow("premium");
  });

  it("throws for divide", () => {
    expect(() => calculate(10, 2, "divide")).toThrow("premium");
  });

  it("isPremium returns true for multiply and divide", () => {
    expect(isPremium("multiply")).toBe(true);
    expect(isPremium("divide")).toBe(true);
  });

  it("isPremium returns false for add and subtract", () => {
    expect(isPremium("add")).toBe(false);
    expect(isPremium("subtract")).toBe(false);
  });
});
