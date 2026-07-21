import { CreditLabelPipe } from './credit-label.pipe';

describe('CreditLabelPipe', () => {
  let pipe: CreditLabelPipe;

  beforeEach(() => {
    pipe = new CreditLabelPipe();
  });

  it('create an instance', () => {
    expect(pipe).toBeTruthy();
  });

  it('should transform 4 credits to include "(Major)"', () => {
    expect(pipe.transform(4)).toBe('4 Credits (Major)');
  });

  it('should transform 3 credits to "3 Credits"', () => {
    expect(pipe.transform(3)).toBe('3 Credits');
  });
});
